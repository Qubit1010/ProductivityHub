"use client";

import { useEffect } from "react";
import { useFocus } from "@/hooks/useAnalytics";
import { toDateString } from "@/lib/utils/date";

const CHECK_MS = 15 * 60 * 1000;

/**
 * Fires browser notifications for daily nudges. Each rule fires once per day
 * via a localStorage key (`reminder:<date>:<ruleId>`) — no table, no scheduler.
 */
export function useReminders() {
  const today = toDateString();
  const { data } = useFocus(today);

  useEffect(() => {
    if (!data) return;

    const check = () => {
      // Safari / denied-permission safe: bail unless explicitly granted
      if (!("Notification" in window) || Notification.permission !== "granted") return;
      const now = new Date();
      const hour = now.getHours();

      const fire = (ruleId: string, body: string) => {
        const key = `reminder:${today}:${ruleId}`;
        if (localStorage.getItem(key)) return;
        localStorage.setItem(key, "1");
        new Notification("ProductivityHub", { body });
      };

      if (hour >= 12 && data.doneToday.tasksTotal === 0) {
        fire("r1-nothing-logged", "Nothing planned or logged today yet.");
      }
      const threeStarOpen = data.undoneToday.filter((t) => t.starRating === 3).length;
      if (hour >= 20 && threeStarOpen > 0) {
        fire(
          "r2-three-star-open",
          `${threeStarOpen} three-star task${threeStarOpen > 1 ? "s" : ""} still open today.`
        );
      }
      if (now.getDay() === 0 && hour >= 18 && data.goalsBehindPace.length > 0) {
        fire(
          "r3-goals-behind",
          `${data.goalsBehindPace.length} weekly goal${data.goalsBehindPace.length > 1 ? "s" : ""} behind pace with the week ending.`
        );
      }
    };

    check();
    const id = setInterval(check, CHECK_MS);
    return () => clearInterval(id);
  }, [data, today]);
}
