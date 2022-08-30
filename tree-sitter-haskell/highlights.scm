;; Early, used for applying italic hightlighting to constraints, which are then later matched as types.
(constraint) @haskell.constraint

[
  "("
  ")"
  ";"
  "["
  "]"
  "{"
  "}"
  (comma)
] @haskell.bracket

[
  "->"
  "::"
  "<-"
  "="
  "=>"
  "@"
  "\\"
  ;; exp_infix (infix operator) does not expose a way to tag the backticks, so the highlight has to be fixed here.
  ;; FIXME This should be fixed in the grammar - a single backtick should not be an operators
  "`"
  "|"
  (constructor_operator)
  ;; Used to highlight the dot following an forall as an operator.
  ;; FIXME This should be fixed in the grammar since it applies operator styles to the whole forall expression.
  (forall)
  (operator)
  ;; Used to highlight the dot separating module names (e.g. in an import).
  ;; FIXME This should be fixed in the grammar since it applies operator styles to the whole forall expression.
  (qualified_module)
  (tycon_arrow)
  (type_operator)
  (wildcard)
] @haskell.operator

[
  "anyclass"
  "as"
  "case"
  "class"
  "data"
  "deriving"
  "do"
  "else"
  "family"
  "forall"
  "hiding"
  "if"
  "import"
  "in"
  "infix"
  "infixl"
  "infixr"
  "instance"
  "let"
  "mdo"
  "module"
  "newtype"
  "of"
  "qualified"
  "rec"
  "stock"
  "then"
  "type"
  "via"
  (where)
] @haskell.keyword

;; Literals
(char) @haskell.character
(exp_negation) @haskell.number
(float) @haskell.number
(integer) @haskell.number
(string) @haskell.string

(comment) @haskell.comment

(pragma) @haskell.pragma

;; Module names are highlighted the same everywhere
(module) @haskell.namespace

;; Highlight `..` in `Foobar(..)`
(all_names) @haskell.import.all

(signature name: (variable) @haskell.declaration)
(function name: (variable) @haskell.definition)

;; Highlight infix functions like operators
(exp_infix (variable) @haskell.operator)

;; Record fields
(field (variable) @haskell.field)
(exp_field (variable) @haskell.field)


;;; Patterns

;; Matched first to support italic highlighting of record patterns
(pat_record) @haskell.pattern
(pat_as) @haskell.pattern
(pat_name) @haskell.pattern
(pat_apply) @haskell.pattern

(pat_name (variable) @haskell.pattern.variable)
(pat_as var: (variable) @haskell.pattern.variable)

;; Record patterns
(pat_field (variable) @field (_))
;; Named field puns
(pat_field (variable) @haskell.pattern.variable .)
(pat_field (qualified_variable (variable)) @haskell.pattern.variable .)

;; Wildcard pattern (`_`)
(pat_wildcard) @haskell.pattern.wildcard

;; Named wilecard pattern (`_foobar`)
(pat_name
  (variable)
  @haskell.pattern.wildcard.named
  (#match? @haskell.pattern.wildcard.named "^_.*"))

;;; End of pattern section


(constructor) @haskell.constructor

;; Unit as constructor
(exp_literal (con_unit) @haskell.constructor (#set! "priority" 150))

(type) @haskell.type
(type_variable) @haskell.type.variable

;; Unit as type
(type_literal (con_unit) @haskell.type (#set! "priority" 150))

;; Template-Haskell
;; Incorrectly applies the quasiquote-style to the whole quasiquote body.
;; FIXME This should be fixed in the grammar (currently the closing `|]` are not exposed as nodes).
(quasiquote) @haskell.quasiquote
(quasiquote_body) @haskell.quasiquote.body
