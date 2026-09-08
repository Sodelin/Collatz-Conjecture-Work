import Lake
open Lake DSL
package strict_newmath where
  leanOptions := #[⟨`autoImplicit, false⟩]
lean_lib Definitions where
lean_lib Theorems where
lean_lib Solutions where
@[default_target]
lean_lib StrictCheck where
