"use client";

import { useState } from "react";
import { AppShell } from "@/components/layout/AppShell";
import { useCategories } from "@/hooks/useCategories";
import { CategoryBadge } from "@/components/shared/CategoryBadge";
import { LoadingSpinner } from "@/components/shared/LoadingSpinner";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Plus, Pencil, Trash2, GripVertical } from "lucide-react";
import { api } from "@/lib/api/client";
import { useQueryClient } from "@tanstack/react-query";
import type { Category } from "@/types";

export default function CategoriesPage() {
  const { data: categories, isLoading } = useCategories();
  const queryClient = useQueryClient();
  const [dialogOpen, setDialogOpen] = useState(false);
  const [editId, setEditId] = useState<string | null>(null);
  const [code, setCode] = useState("");
  const [name, setName] = useState("");
  const [color, setColor] = useState("#6B7280");
  const [type, setType] = useState("general");

  if (isLoading) return <AppShell><LoadingSpinner /></AppShell>;

  function resetForm() {
    setEditId(null);
    setCode("");
    setName("");
    setColor("#6B7280");
    setType("general");
  }

  function openEdit(cat: Category) {
    setEditId(cat.id);
    setCode(cat.code);
    setName(cat.name);
    setColor(cat.color);
    setType(cat.type);
    setDialogOpen(true);
  }

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    if (editId) {
      await api.categories.update(editId, { code, name, color, type });
    } else {
      await api.categories.create({ code, name, color, type });
    }
    queryClient.invalidateQueries({ queryKey: ["categories"] });
    setDialogOpen(false);
    resetForm();
  }

  async function handleDelete(id: string) {
    await api.categories.delete(id);
    queryClient.invalidateQueries({ queryKey: ["categories"] });
  }

  return (
    <AppShell>
      <div className="space-y-6">
        <div className="flex items-center justify-between">
          <h1 className="text-3xl font-bold">Categories</h1>
          <Dialog open={dialogOpen} onOpenChange={(open) => { setDialogOpen(open); if (!open) resetForm(); }}>
            <DialogTrigger asChild>
              <Button><Plus className="h-4 w-4 mr-2" />Add Category</Button>
            </DialogTrigger>
            <DialogContent>
              <DialogHeader>
                <DialogTitle>{editId ? "Edit" : "Add"} Category</DialogTitle>
              </DialogHeader>
              <form onSubmit={handleSubmit} className="space-y-4">
                <div className="space-y-2">
                  <Label>Code</Label>
                  <Input value={code} onChange={(e) => setCode(e.target.value)} placeholder="e.g. UN" maxLength={10} required />
                </div>
                <div className="space-y-2">
                  <Label>Name</Label>
                  <Input value={name} onChange={(e) => setName(e.target.value)} placeholder="e.g. University" required />
                </div>
                <div className="space-y-2">
                  <Label>Color</Label>
                  <div className="flex gap-2 items-center">
                    <input type="color" value={color} onChange={(e) => setColor(e.target.value)} className="h-10 w-10 rounded border cursor-pointer" />
                    <Input value={color} onChange={(e) => setColor(e.target.value)} className="flex-1" />
                  </div>
                </div>
                <div className="space-y-2">
                  <Label>Type</Label>
                  <Select value={type} onValueChange={setType}>
                    <SelectTrigger><SelectValue /></SelectTrigger>
                    <SelectContent>
                      {["general", "work", "education", "personal", "freelance", "business", "tech", "marketing", "learning", "priority"].map((t) => (
                        <SelectItem key={t} value={t}>{t}</SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                </div>
                <Button type="submit" className="w-full">{editId ? "Update" : "Create"}</Button>
              </form>
            </DialogContent>
          </Dialog>
        </div>

        <div className="space-y-2">
          {(categories || []).map((cat: Category) => (
            <Card key={cat.id}>
              <CardContent className="flex items-center gap-4 p-4">
                <GripVertical className="h-4 w-4 text-muted-foreground cursor-grab" />
                <div className="h-4 w-4 rounded-full" style={{ backgroundColor: cat.color }} />
                <CategoryBadge category={cat} />
                <span className="flex-1 font-medium">{cat.name}</span>
                <span className="text-sm text-muted-foreground">{cat.type}</span>
                <Button variant="ghost" size="icon" onClick={() => openEdit(cat)}>
                  <Pencil className="h-4 w-4" />
                </Button>
                <Button variant="ghost" size="icon" onClick={() => handleDelete(cat.id)}>
                  <Trash2 className="h-4 w-4 text-red-500" />
                </Button>
              </CardContent>
            </Card>
          ))}
        </div>
      </div>
    </AppShell>
  );
}
