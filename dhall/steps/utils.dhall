let Map/Type =
      https://prelude.dhall-lang.org/Map/Type.dhall sha256:210c7a9eba71efbb0f7a66b3dcf8b9d3976ffc2bc0e907aadfb6aa29c333e8ed

let Map/map =
      https://prelude.dhall-lang.org/Map/map.dhall sha256:23e09b0b9f08649797dfe1ca39755d5e1c7cad2d0944bdd36c7a0bf804bde8d0

let Map/unpackOptionals =
      https://prelude.dhall-lang.org/Map/unpackOptionals.dhall sha256:66c3e6f6f81418cf99342e1dba739617c01af4b27c1ca5e2e1d7bce64a522e22

let mapToSome
    : ∀(m : Map/Type Text Text) → Map/Type Text (Optional Text)
    = Map/map Text Text (Optional Text) (λ(value : Text) → Some value)

let __test__mapToSome =
      assert : mapToSome (toMap { foo = "bar" }) ≡ toMap { foo = Some "bar" }

let unpackTextOptions
    : ∀(k : Map/Type Text (Optional Text)) → Map/Type Text Text
    = Map/unpackOptionals Text Text

let __test__unpackTextOptions =
        assert
      : unpackTextOptions (toMap { foo = Some "bar" }) ≡ toMap { foo = "bar" }

let withInputs
    : ∀(requiredInput : Map/Type Text Text) →
      ∀(optionalInput : Map/Type Text (Optional Text)) →
        Map/Type Text Text
    =
      {-
        Convert Github Action inputs (required: Bool) to `with` friendly list.
        As not all Github Action inputs are requied, this function helps having
        an step interface with required input as `Text` and no requied input as
        `Optional Text`.
      -}
      λ(requiredInput : Map/Type Text Text) →
      λ(optionalInput : Map/Type Text (Optional Text)) →
        unpackTextOptions (optionalInput # mapToSome requiredInput)

let __test__withInputs =
      let MyInput =
            { Type =
                { required : Text
                , optional : Optional Text
                , O_o : Optional Text
                }
            , default = { optional = None Text, O_o = None Text }
            }

      let my_inputs
          : MyInput.Type
          = MyInput::{ required = "required", optional = Some "optional" }

      in    assert
          :   withInputs
                (toMap my_inputs.{ required })
                (toMap (my_inputs ⫽ { required = None Text }))
            ≡ toMap { required = "required", optional = "optional" }

in  { withInputs, unpackTextOptions }
