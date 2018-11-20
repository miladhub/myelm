import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

main =
  Browser.sandbox { init = init, update = update, view = view }

type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  , age : String
  , submitted : Bool
  }

init : Model
init =
  Model "" "" "" "" False

type Msg
  = Name String
  | Password String
  | PasswordAgain String
  | Age String
  | Submit

update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }
    Password password ->
      { model | password = password }
    PasswordAgain password ->
      { model | passwordAgain = password }
    Age age ->
      { model | age = age }
    Submit ->
      { model | submitted = True }

view : Model -> Html Msg
view model =
  div []
    [ viewInput "text" "Name" model.name Name
    , viewInput "password" "Password" model.password Password
    , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
    , viewInput "text" "Age" model.age Age
    , button [ onClick Submit ] [ text "Submit" ]
    , viewValidation model
    ]

viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg ] []

viewValidation : Model -> Html msg
viewValidation model =
  if not (model.submitted) then
    div [ style "color" "green" ] [ text "OK" ]
  else if model.password /= model.passwordAgain then
    error"Passwords do not match!"
  else if String.length model.password < 8 then
    error "Length should be >= 8"
  else if (String.isEmpty << String.filter Char.isUpper) model.password then
    error "Must contain capital letters"
  else if (not << String.isEmpty << String.filter (not << Char.isDigit)) model.age then
    error "Age must be a number"
  else
    div [ style "color" "green" ] [ text "OK" ]
    
error : String -> Html msg
error err =
  div [ style "color" "red" ] [ text err ]

