Set Implicit Arguments.

(* a *)
Goal forall (X Y : Prop), ~(X /\ Y) \/ (~X /\ Y) \/ (~X /\ ~Y) <-> ~ (X /\ Y).
Proof.
  intros. split.
  - intros [A | [B | C]].
    -- now intros.
    -- intros [x y]. now destruct B.
    -- destruct C as [nx ny]. now intros.
  - intros. now left.
Qed.

(* b *)
Goal forall (X Y Z : Prop), ~(~X /\ Y /\ ~Z) /\ ~(X /\ Y /\ Z) /\  (X /\ ~Y /\ ~Z) <-> (X /\ ~(Y \/ Z)).
Proof.
  intros. split.
  - intros [A [B [x [ny nz]]]]. split.
    -- exact x.
    -- intros [y | z] ; try now apply ny ; try apply nz.
  - intros [x A]. split.
    -- intros [nx [y z]]. now apply nx.
    -- split.
      --- intros [_ [y z]]. apply A. now left.
      --- split ; try assumption. split ; intros B ; apply A ; try now left. now right.
Qed.

