"use client";

import { useQuery } from "@tanstack/react-query";
import { api } from "@/lib/api/client";

export function useAnalyticsSummary(from: string, to: string) {
  return useQuery({
    queryKey: ["analytics", "summary", from, to],
    queryFn: () => api.analytics.summary(from, to),
  });
}

export function useDailyBreakdown(from: string, to: string) {
  return useQuery({
    queryKey: ["analytics", "dailyBreakdown", from, to],
    queryFn: () => api.analytics.dailyBreakdown(from, to),
    select: (data) => data.days,
  });
}

export function useStreaks() {
  return useQuery({
    queryKey: ["analytics", "streaks"],
    queryFn: () => api.analytics.streaks(),
  });
}

export function useInsights(from: string, to: string) {
  return useQuery({
    queryKey: ["analytics", "insights", from, to],
    queryFn: () => api.analytics.insights(from, to),
  });
}

export function useFocus(date: string) {
  return useQuery({
    queryKey: ["analytics", "focus", date],
    queryFn: () => api.analytics.focus(date),
  });
}

export function useLeverageTrend(from: string, to: string) {
  return useQuery({
    queryKey: ["analytics", "leverageTrend", from, to],
    queryFn: () => api.analytics.leverageTrend(from, to),
    select: (data) => data.weeks,
  });
}

export function useMomentum(from: string, to: string) {
  return useQuery({
    queryKey: ["analytics", "momentum", from, to],
    queryFn: () => api.analytics.momentum(from, to),
    select: (data) => data.items,
  });
}

export function useWeeklyScorecard() {
  return useQuery({
    queryKey: ["analytics", "scorecard"],
    queryFn: () => api.analytics.scorecard(),
    staleTime: 5 * 60 * 1000,
  });
}

// on-demand: fires only when refetch() is called, then cached for the session per range
export function useAiAnalysis(from: string, to: string) {
  return useQuery({
    queryKey: ["analytics", "aiAnalysis", from, to],
    queryFn: () => api.analytics.aiAnalysis(from, to),
    enabled: false,
    staleTime: Infinity,
    gcTime: Infinity,
    retry: false,
  });
}
