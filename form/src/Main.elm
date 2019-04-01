module Main exposing (Model, Msg(..), init, main, update, view, viewInput, viewValidation)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    , age : String
    , submitted : Bool
    , error : Maybe String
    }


init : Model
init =
    Model "" "" "" "42" False Nothing


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
            { model | submitted = True, error = modelValidation model }


modelValidation : Model -> Maybe String
modelValidation model =
    if model.password == model.passwordAgain then
        case String.toInt model.age of
            Just age ->
                Nothing

            Nothing ->
                Just "Age must be a number!"

    else
        Just "Passwords do not match!"


view : Model -> Html Msg
view model =
    div []
        [ viewInput "text" "Name" model.name Name
        , viewInput "password" "Password" model.password Password
        , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
        , viewInput "text" "Age" model.age Age
        , viewValidation model
        , button [ onClick Submit ] [ text "Submit" ]
        ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
    input [ type_ t, placeholder p, value v, onInput toMsg ] []


viewValidation : Model -> Html msg
viewValidation model =
    if model.submitted then
        case model.error of
            Just error ->
                div [ style "color" "red" ] [ text error ]

            Nothing ->
                div [ style "color" "green" ] [ text "OK" ]

    else
        div [ style "color" "green" ] [ text "OK" ]
