import * as React from "react";
import { cn } from "../../lib/utils.ts";// optional: only if you're using a className utility

interface CardProps extends React.HTMLAttributes<HTMLDivElement> {}

export function Card({ className, ...props }: CardProps) {
  return (
    <div className={cn("rounded-2xl border bg-white p-6 shadow-sm", className)} {...props} />
  );
}

export function CardHeader({ className, ...props }: CardProps) {
  return (
    <div className={cn("text-xl font-bold mb-4", className)} {...props} />
  );
}

export function CardContent({ className, ...props }: CardProps) {
  return (
    <div className={cn("text-sm text-gray-700", className)} {...props} />
  );
}
