import { Card, CardContent } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Droplets, MapPin, Ruler, Weight, AlertTriangle } from 'lucide-react';
import type { BasicDataDTO } from '@/types/session.types';

interface PatientInfoCardProps {
  data: BasicDataDTO;
  compact?: boolean;
}

export default function PatientInfoCard({ data, compact }: PatientInfoCardProps) {
  const allergiesList = data.allergies
    ? data.allergies.split(',').map((a) => a.trim()).filter(Boolean)
    : [];

  return (
    <Card>
      <CardContent className={compact ? 'p-4' : 'p-6'}>
        <div className="flex items-start gap-4">
          {/* Avatar */}
          {data.image ? (
            <img
              src={data.image}
              alt={data.fullName}
              className="h-16 w-16 rounded-2xl object-cover flex-shrink-0"
            />
          ) : (
            <div className="h-16 w-16 rounded-2xl bg-primary/10 flex items-center justify-center flex-shrink-0">
              <span className="text-primary font-bold text-xl">
                {data.fullName
                  ?.split(' ')
                  .map((n) => n[0])
                  .join('')}
              </span>
            </div>
          )}

          <div className="flex-1">
            <div className="flex items-start justify-between flex-wrap gap-2">
              <div>
                <h2 className={compact ? 'text-lg font-semibold' : 'text-2xl font-bold'}>
                  {data.fullName}
                </h2>
                <p className="text-muted-foreground font-mono text-sm">
                  {data.careTagId}
                </p>
              </div>
              <Badge variant="outline">{data.gender}</Badge>
            </div>

            <div className="mt-3 flex flex-wrap gap-4 text-sm text-muted-foreground">
              {data.dob && (
                <span>
                  <strong>DOB:</strong> {data.dob}
                </span>
              )}
              {data.bloodGroup && (
                <span className="flex items-center gap-1">
                  <Droplets className="h-3.5 w-3.5 text-red-500" />
                  <strong>Blood:</strong> {data.bloodGroup}
                </span>
              )}
              {data.height && (
                <span className="flex items-center gap-1">
                  <Ruler className="h-3.5 w-3.5" />
                  {data.height}
                </span>
              )}
              {data.weight && (
                <span className="flex items-center gap-1">
                  <Weight className="h-3.5 w-3.5" />
                  {data.weight}
                </span>
              )}
            </div>

            {data.address && (
              <p className="mt-2 text-sm text-muted-foreground flex items-center gap-1">
                <MapPin className="h-3.5 w-3.5 flex-shrink-0" />
                {data.address}
              </p>
            )}
          </div>
        </div>

        {/* Allergies */}
        {allergiesList.length > 0 && (
          <div className="mt-4 pt-4 border-t">
            <p className="text-sm font-medium flex items-center gap-1.5 mb-2">
              <AlertTriangle className="h-4 w-4 text-destructive" />
              Allergies
            </p>
            <div className="flex flex-wrap gap-2">
              {allergiesList.map((a) => (
                <Badge key={a} variant="destructive">
                  {a}
                </Badge>
              ))}
            </div>
          </div>
        )}
      </CardContent>
    </Card>
  );
}
