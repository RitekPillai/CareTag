import { useState, useEffect } from 'react';

function pad(n: number): string {
  return n.toString().padStart(2, '0');
}

export function useSessionTimer(startedAt: number | null): string {
  const [elapsed, setElapsed] = useState('00:00:00');

  useEffect(() => {
    if (!startedAt) {
      setElapsed('00:00:00');
      return;
    }

    const update = () => {
      const diff = Date.now() - startedAt;
      const h = Math.floor(diff / 3600000);
      const m = Math.floor((diff % 3600000) / 60000);
      const s = Math.floor((diff % 60000) / 1000);
      setElapsed(`${pad(h)}:${pad(m)}:${pad(s)}`);
    };

    update();
    const interval = setInterval(update, 1000);
    return () => clearInterval(interval);
  }, [startedAt]);

  return elapsed;
}
