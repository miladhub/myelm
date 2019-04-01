module Main exposing (Color(..), Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { color : Color
    , result : String
    }


type Color
    = Red
    | Blue
    | Black


init : Model
init =
    { result = "red!", color = Red }


type Msg
    = Choose String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Choose "red" ->
            { model | result = "red!", color = Red }

        Choose "blue" ->
            { model | result = "blue!", color = Blue }

        Choose _ ->
            { model | result = "Error", color = Black }


view : Model -> Html Msg
view model =
    div []
        [ select [ onInput Choose ]
            [ option [ value "red" ] [ text "Red" ]
            , option [ value "blue" ] [ text "Blue" ]
            ]
        , text model.result
        ]
