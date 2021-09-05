output "dashboard_id" {
  description = "The resource ID of the Dashboard"
  value       = [for k in azurerm_dashboard.main : k.id]
}
