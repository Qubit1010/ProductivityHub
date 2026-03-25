"use client";

import { Badge } from "@/components/ui/badge";
import type { Category } from "@/types";

interface CategoryBadgeProps {
  category: Category;
  className?: string;
}

export function CategoryBadge({ category, className }: CategoryBadgeProps) {
  return (
    <Badge
      variant="outline"
      className={className}
      style={{
        borderColor: category.color,
        color: category.color,
        backgroundColor: `${category.color}15`,
      }}
    >
      {category.code}
    </Badge>
  );
}
