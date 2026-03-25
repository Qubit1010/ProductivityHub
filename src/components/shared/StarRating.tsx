"use client";

import { Star } from "lucide-react";
import { cn } from "@/lib/utils";

interface StarRatingProps {
  value: number;
  max?: number;
  editable?: boolean;
  onChange?: (value: number) => void;
  size?: number;
  className?: string;
}

export function StarRating({
  value,
  max = 3,
  editable = false,
  onChange,
  size = 16,
  className,
}: StarRatingProps) {
  return (
    <div className={cn("flex items-center gap-0.5", className)}>
      {Array.from({ length: max }, (_, i) => {
        const starValue = i + 1;
        const filled = starValue <= value;

        return (
          <button
            key={i}
            type="button"
            disabled={!editable}
            onClick={() => {
              if (editable && onChange) {
                onChange(starValue === value ? starValue - 1 : starValue);
              }
            }}
            className={cn(
              "transition-colors",
              editable
                ? "cursor-pointer hover:text-yellow-400"
                : "cursor-default"
            )}
          >
            <Star
              size={size}
              className={cn(
                filled
                  ? "fill-yellow-400 text-yellow-400"
                  : "fill-none text-muted-foreground/40"
              )}
            />
          </button>
        );
      })}
    </div>
  );
}
