package pl.planik.presentation.plan

sealed class PlanAction {
  object Today : PlanAction()
  object TogglePlanViewType : PlanAction()
}