export const DEFAULT_CATEGORIES = [
  { code: "IM", name: "Important", color: "#EF4444", type: "priority" },
  { code: "Projs", name: "Projects", color: "#3B82F6", type: "work" },
  { code: "UN", name: "University", color: "#8B5CF6", type: "education" },
  { code: "CR", name: "Code Review", color: "#06B6D4", type: "work" },
  { code: "SM", name: "Social Media", color: "#F59E0B", type: "marketing" },
  { code: "UP", name: "Upwork", color: "#10B981", type: "freelance" },
  { code: "FR", name: "Freelance", color: "#14B8A6", type: "freelance" },
  { code: "AGN", name: "Agency", color: "#EC4899", type: "business" },
  { code: "RD", name: "Research & Development", color: "#6366F1", type: "learning" },
  { code: "ATs", name: "Automations", color: "#F97316", type: "tech" },
  { code: "TIs", name: "Tools", color: "#84CC16", type: "tech" },
  { code: "WK", name: "Work", color: "#22C55E", type: "general" },
  { code: "PR", name: "Personal", color: "#E11D48", type: "personal" },
  { code: "LR", name: "Learning", color: "#EAB308", type: "education" },
] as const;

export const NAV_ITEMS = [
  { href: "/", label: "Dashboard", icon: "LayoutDashboard" },
  { href: "/today", label: "Today", icon: "CalendarCheck" },
  { href: "/week", label: "Week", icon: "CalendarDays" },
  { href: "/analytics", label: "Analytics", icon: "BarChart3" },
  { href: "/backlog", label: "Backlog", icon: "ListTodo" },
  { href: "/categories", label: "Categories", icon: "Tags" },
  { href: "/import", label: "Import", icon: "Upload" },
  { href: "/settings", label: "Settings", icon: "Settings" },
] as const;
