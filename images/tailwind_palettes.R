# Update the tailwind palettes now that the colours have changed on the website
new_default_colour_palette <- c(
  'black' = "#000000", 
  'white' = "#FFFFFF", 
  'gray-50'  = "#F9FAFB",
  'gray-100' = "#F3F4F6",
  'gray-200' = "#E5E7EB",
  'gray-300' = "#D1D5DB",
  'gray-400' = "#9CA3AF",
  'gray-500' = "#6B7280",
  'gray-600' = "#4B5563",
  'gray-700' = "#374151",
  'gray-800' = "#1F2937",
  'gray-900' = "#111827",
  'red-50'  = "#FEF2F2",
  'red-100' = "#FEE2E2",
  'red-200' = "#FECACA",
  'red-300' = "#FCA5A5",
  'red-400' = "#F87171",
  'red-500' = "#EF4444",
  'red-600' = "#DC2626",
  'red-700' = "#B91C1C",
  'red-800' = "#991B1B",
  'red-900' = "#7F1D1D",
  'yellow-50'  = "#FFFBEB",
  'yellow-100' = "#FEF3C7",
  'yellow-200' = "#FDE68A",
  'yellow-300' = "#FCD34D",
  'yellow-400' = "#FBBF24",
  'yellow-500' = "#F59E0B",
  'yellow-600' = "#D97706",
  'yellow-700' = "#B45309",
  'yellow-800' = "#92400E",
  'yellow-900' = "#78350F",
  'green-50'  = "#ECFDF5",
  'green-100' = "#D1FAE5",
  'green-200' = "#A7F3D0",
  'green-300' = "#6EE7B7",
  'green-400' = "#34D399",
  'green-500' = "#10B981",
  'green-600' = "#059669",
  'green-700' = "#047857",
  'green-800' = "#065F46",
  'green-900' = "#064E3B",
  'blue-50'  = "#EFF6FF",
  'blue-100' = "#DBEAFE",
  'blue-200' = "#BFDBFE",
  'blue-300' = "#93C5FD",
  'blue-400' = "#60A5FA",
  'blue-500' = "#3B82F6",
  'blue-600' = "#2563EB",
  'blue-700' = "#1D4ED8",
  'blue-800' = "#1E40AF",
  'blue-900' = "#1E3A8A",
  'indigo-50'  = "#EEF2FF",
  'indigo-100' = "#E0E7FF",
  'indigo-200' = "#C7D2FE",
  'indigo-300' = "#A5B4FC",
  'indigo-400' = "#818CF8",
  'indigo-500' = "#6366F1",
  'indigo-600' = "#4F46E5",
  'indigo-700' = "#4338CA",
  'indigo-800' = "#3730A3",
  'indigo-900' = "#312E81",
  'purple-50'  = "#F5F3FF",
  'purple-100' = "#EDE9FE",
  'purple-200' = "#DDD6FE",
  'purple-300' = "#C4B5FD",
  'purple-400' = "#A78BFA",
  'purple-500' = "#8B5CF6",
  'purple-600' = "#7C3AED",
  'purple-700' = "#6D28D9",
  'purple-800' = "#5B21B6",
  'purple-900' = "#4C1D95",
  'pink-50'  = "#FDF2F8",
  'pink-100' = "#FCE7F3",
  'pink-200' = "#FBCFE8",
  'pink-300' = "#F9A8D4",
  'pink-400' = "#F472B6",
  'pink-500' = "#EC4899",
  'pink-600' = "#DB2777",
  'pink-700' = "#BE185D",
  'pink-800' = "#9D174D",
  'pink-900' = "#831843"
)

new_tailwind_palettes <- list(
  'main' = new_default_colour_palette, 
  'gray' = new_default_colour_palette[grep('gray-.*', names(new_default_colour_palette))],
  'red' = new_default_colour_palette[grep('red-.*', names(new_default_colour_palette))], 
  'yellow' = new_default_colour_palette[grep('yellow-.*', names(new_default_colour_palette))],
  'green' = new_default_colour_palette[grep('green-.*', names(new_default_colour_palette))],
  'blue' = new_default_colour_palette[grep('blue-.*', names(new_default_colour_palette))], 
  'indigo' = new_default_colour_palette[grep('indigo-.*', names(new_default_colour_palette))],
  'purple' = new_default_colour_palette[grep('purple-.*', names(new_default_colour_palette))],
  'pink' = new_default_colour_palette[grep('pink-.*', names(new_default_colour_palette))],
  '50' = new_default_colour_palette[grep('.*-50$', names(new_default_colour_palette))],
  '100' = new_default_colour_palette[grep('.*-100', names(new_default_colour_palette))],
  '200' = new_default_colour_palette[grep('.*-200', names(new_default_colour_palette))],
  '300' = new_default_colour_palette[grep('.*-300', names(new_default_colour_palette))],
  '400' = new_default_colour_palette[grep('.*-400', names(new_default_colour_palette))],
  '500' = new_default_colour_palette[grep('.*-500', names(new_default_colour_palette))],
  '600' = new_default_colour_palette[grep('.*-600', names(new_default_colour_palette))],
  '700' = new_default_colour_palette[grep('.*-700', names(new_default_colour_palette))],
  '800' = new_default_colour_palette[grep('.*-800', names(new_default_colour_palette))],
  '900' = new_default_colour_palette[grep('.*-900', names(new_default_colour_palette))]
)

save(default_colour_palette, file = 'data/default_colour_palette.rda')
save(tailwind_palettes, file = 'data/tailwind_palettes.rda')
tailwind_palettes <- new_tailwind_palettes
install.packages('devtools')
library(roxygen2)

library(devtools)
install.packages('testthat')

devtools::load_all('../ggtailwind')
devtools::document()

rename_rda(oldname= 'new_default_colour_palette', oldfile='data/default_colour_palette.rda', newname='default_colour_palette', newfile='data/default_colour_palette.rda')
default_colour_palette <- new_default_colour_palette

