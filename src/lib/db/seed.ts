import { db } from "./index";
import { categories } from "./schema";
import { DEFAULT_CATEGORIES } from "../constants";

export async function seedDefaultCategories(userId: string) {
  const values = DEFAULT_CATEGORIES.map((cat, index) => ({
    userId,
    code: cat.code,
    name: cat.name,
    color: cat.color,
    type: cat.type,
    sortOrder: index,
  }));

  await db.insert(categories).values(values);
}
