package pl.planik.presentation.create.plan

sealed class CreatePlanAction {
  data class PlanNameTextChanges(val text: String = "") : CreatePlanAction()
}