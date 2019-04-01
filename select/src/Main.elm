import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)

main =
    Browser.sandbox { init = init, update = update, view = view }

type alias Model =
  Red
  | Blue

init : Model
init =
  Red

type Msg =
  Choose String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Choose color = 
