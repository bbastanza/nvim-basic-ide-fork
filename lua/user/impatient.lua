local status_ok, impatient = pcall(require, "impatient")
if not status_ok then
  vim.notify("impatient failed to load. file: " .. "impatient.lua")
  return
end

impatient.enable_profile()
