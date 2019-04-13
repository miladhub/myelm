module Main exposing (Model, Msg(..), init, main, subscriptions, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Random


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


type alias Model =
    { dieFace : Int
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model 1
    , Cmd.none
    )


type Msg
    = Roll
    | NewFace Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model
            , Random.generate NewFace (Random.int 1 6)
            )

        NewFace newFace ->
            ( Model newFace
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    div []
        [ showImage model.dieFace
        , button [ onClick Roll ] [ text "Roll" ]
        ]


showImage : Int -> Html Msg
showImage i =
    img
        [ src (imgUrl i), height 300, width 300 ]
        []


imgUrl : Int -> String
imgUrl i =
    case i of
        1 ->
            "https://game-icons.net/icons/ffffff/000000/1x1/delapouite/dice-six-faces-one.svg"

        2 ->
            "https://game-icons.net/icons/ffffff/000000/1x1/delapouite/dice-six-faces-two.svg"

        3 ->
            "https://game-icons.net/icons/ffffff/000000/1x1/delapouite/dice-six-faces-three.svg"

        4 ->
            "https://game-icons.net/icons/ffffff/000000/1x1/delapouite/dice-six-faces-four.svg"

        5 ->
            "https://game-icons.net/icons/ffffff/000000/1x1/delapouite/dice-six-faces-five.svg"

        6 ->
            "https://game-icons.net/icons/ffffff/000000/1x1/delapouite/dice-six-faces-six.svg"

        _ ->
            "Bad number"
