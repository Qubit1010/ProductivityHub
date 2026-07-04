"use client";

import { RefreshCw, Sparkles } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { LoadingSpinner } from "@/components/shared/LoadingSpinner";
import { useAiAnalysis } from "@/hooks/useAnalytics";

interface AICoachPanelProps {
  from: string;
  to: string;
}

export function AICoachPanel({ from, to }: AICoachPanelProps) {
  const { data, isFetching, isError, error, refetch } = useAiAnalysis(from, to);

  return (
    <Card>
      <CardHeader>
        <div className="flex items-center justify-between">
          <CardTitle className="flex items-center gap-2 text-base">
            <Sparkles className="h-4 w-4 text-primary" />
            AI time coach
          </CardTitle>
          {data && !isFetching && (
            <Button variant="ghost" size="sm" onClick={() => refetch()}>
              <RefreshCw className="mr-1 h-3.5 w-3.5" />
              Re-analyze
            </Button>
          )}
        </div>
      </CardHeader>
      <CardContent>
        {isFetching ? (
          <div className="flex h-24 items-center justify-center">
            <LoadingSpinner />
          </div>
        ) : isError ? (
          <div className="space-y-3">
            <p className="text-sm text-muted-foreground">
              {(error as Error)?.message ?? "Couldn't analyze your time."}
            </p>
            <Button size="sm" onClick={() => refetch()}>
              Try again
            </Button>
          </div>
        ) : data ? (
          <div className="space-y-4">
            <p className="text-lg font-semibold">{data.headline}</p>
            {data.whereTimeWent && (
              <p className="text-sm text-muted-foreground">{data.whereTimeWent}</p>
            )}
            <div className="grid gap-4 sm:grid-cols-2">
              {data.whatsWorking.length > 0 && (
                <div>
                  <p className="mb-1.5 text-xs font-medium text-emerald-600 dark:text-emerald-500">
                    What&apos;s working
                  </p>
                  <ul className="list-disc space-y-1 pl-4 text-sm">
                    {data.whatsWorking.map((x, i) => (
                      <li key={i}>{x}</li>
                    ))}
                  </ul>
                </div>
              )}
              {data.whatToChange.length > 0 && (
                <div>
                  <p className="mb-1.5 text-xs font-medium text-amber-600 dark:text-amber-500">
                    What to change
                  </p>
                  <ul className="list-disc space-y-1 pl-4 text-sm">
                    {data.whatToChange.map((x, i) => (
                      <li key={i}>{x}</li>
                    ))}
                  </ul>
                </div>
              )}
            </div>
            {data.oneThingThisWeek && (
              <div className="rounded-md border border-primary/30 bg-primary/5 p-3">
                <p className="text-xs font-medium text-muted-foreground">One thing this week</p>
                <p className="text-sm font-medium">{data.oneThingThisWeek}</p>
              </div>
            )}
          </div>
        ) : (
          <div className="flex flex-col items-start gap-3">
            <p className="text-sm text-muted-foreground">
              Let AI read your numbers and tell you where your time went and what to change.
            </p>
            <Button size="sm" onClick={() => refetch()}>
              <Sparkles className="mr-1 h-3.5 w-3.5" />
              Analyze my time
            </Button>
          </div>
        )}
      </CardContent>
    </Card>
  );
}
