import { useState, useCallback } from 'react';
import { useQuery } from '@tanstack/react-query';
import { debounce } from '@/lib/utils';

interface DrugSuggestion {
  brandName: string;
  genericName: string;
  manufacturer: string;
}

interface DrugValidationResult {
  valid: boolean;
  suggestions: DrugSuggestion[];
  totalResults: number;
  message: string;
}

export function useDrugValidation(drugName: string, enabled: boolean = true) {
  return useQuery({
    queryKey: ['drug-validation', drugName],
    queryFn: async (): Promise<DrugValidationResult> => {
      if (!drugName || drugName.trim().length < 2) {
        return { valid: false, suggestions: [], totalResults: 0, message: '' };
      }

      const encoded = encodeURIComponent(drugName.trim());
      const url = `https://api.fda.gov/drug/label.json?search=openfda.brand_name:"${encoded}"+openfda.generic_name:"${encoded}"&limit=5`;

      const res = await fetch(url);

      if (res.status === 404) {
        // No results found — try a looser search for suggestions
        const looseUrl = `https://api.fda.gov/drug/label.json?search=openfda.brand_name:${encoded}+openfda.generic_name:${encoded}&limit=5`;
        const looseRes = await fetch(looseUrl);

        if (!looseRes.ok || looseRes.status === 404) {
          return { valid: false, suggestions: [], totalResults: 0, message: 'Drug not found in FDA database' };
        }

        const looseData = await looseRes.json();
        const suggestions: DrugSuggestion[] = (looseData.results || []).map((r: any) => ({
          brandName: r.openfda?.brand_name?.[0] ?? '',
          genericName: r.openfda?.generic_name?.[0] ?? '',
          manufacturer: r.openfda?.manufacturer_name?.[0] ?? '',
        }));

        return { valid: false, suggestions, totalResults: suggestions.length, message: 'Did you mean one of these?' };
      }

      if (!res.ok) {
        throw new Error(`FDA API error: ${res.status}`);
      }

      const data = await res.json();
      const results = data.results || [];

      // Exact match check
      const exactMatch = results.some((r: any) => {
        const brands: string[] = (r.openfda?.brand_name || []).map((n: string) => n.toLowerCase());
        const generics: string[] = (r.openfda?.generic_name || []).map((n: string) => n.toLowerCase());
        return brands.includes(drugName.trim().toLowerCase()) || generics.includes(drugName.trim().toLowerCase());
      });

      const suggestions: DrugSuggestion[] = results.map((r: any) => ({
        brandName: r.openfda?.brand_name?.[0] ?? '',
        genericName: r.openfda?.generic_name?.[0] ?? '',
        manufacturer: r.openfda?.manufacturer_name?.[0] ?? '',
      }));

      return {
        valid: exactMatch,
        suggestions: exactMatch ? [] : suggestions,
        totalResults: data.meta?.results?.total ?? results.length,
        message: exactMatch ? 'FDA Verified' : 'Did you mean one of these?',
      };
    },
    enabled: enabled && drugName.trim().length >= 2,
    staleTime: 1000 * 60 * 5, // Cache for 5 minutes
    gcTime: 1000 * 60 * 10,
    retry: false, // Don't retry 404s
  });
}

export function useDrugSearch() {
  const [searchTerm, setSearchTerm] = useState('');
  const [debouncedTerm, setDebouncedTerm] = useState('');

  // Debounced search term update
  const debouncedSetSearch = useCallback(
    debounce((value: string) => {
      setDebouncedTerm(value);
    }, 500),
    []
  );

  const updateSearch = (value: string) => {
    setSearchTerm(value);
    debouncedSetSearch(value);
  };

  const validation = useDrugValidation(debouncedTerm, debouncedTerm.length >= 2);

  return {
    searchTerm,
    updateSearch,
    ...validation,
    isSearching: validation.isLoading && debouncedTerm.length >= 2,
  };
}
