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
    { dieFace1 : Int
    , dieFace2 : Int
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model 1 1
    , Cmd.none
    )


type Msg
    = Roll
    | NewFace Model


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model
            , generateFace
            )

        NewFace m ->
            ( m
            , Cmd.none
            )


generateFace : Cmd Msg
generateFace =
    Random.generate NewFace facesGenerator


facesGenerator : Random.Generator Model
facesGenerator =
    Random.map2 Model (Random.int 1 6) (Random.int 1 6)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    div []
        [ showImage model.dieFace1
        , button [ onClick Roll ] [ text "Roll" ]
        , showImage model.dieFace2
        ]


showImage : Int -> Html Msg
showImage i =
    img
        [ src (imgUrl i), height 50, width 50 ]
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
