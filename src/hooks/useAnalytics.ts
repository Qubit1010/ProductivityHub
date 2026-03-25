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

export function useCategoryTrends(from: string, to: string) {
  return useQuery({
    queryKey: ["analytics", "categoryTrends", from, to],
    queryFn: () => api.analytics.categoryTrends(from, to),
    select: (data) => data.trends,
  });
}

export function useHourlyDistribution(from: string, to: string) {
  return useQuery({
    queryKey: ["analytics", "hourlyDistribution", from, to],
    queryFn: () => api.analytics.hourlyDistribution(from, to),
    select: (data) => data.hours,
  });
}

export function useStreaks() {
  return useQuery({
    queryKey: ["analytics", "streaks"],
    queryFn: () => api.analytics.streaks(),
  });
}

export function useSprintAdherence(from: string, to: string) {
  return useQuery({
    queryKey: ["analytics", "sprintAdherence", from, to],
    queryFn: () => api.analytics.sprintAdherence(from, to),
    select: (data) => data.days,
  });
}
