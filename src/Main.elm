module Main exposing (..)

-- Press buttons to increment and decrement a counter.
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/buttons.html
--

import Browser
import Html exposing (Html, button, div, hr, text)
import Html.Attributes exposing (disabled)
import Html.Events exposing (onClick)



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { count : Int, status : Status }


init : Model
init =
    { count = 0, status = Opened }

type Status
    = Opened
    | Closed
    | Problem


-- UPDATE


type Msg
    = Increment
    | Decrement
    | Reset
    | Open
    | Close
    | MakeProblems


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | count = model.count + 1 }

        Decrement ->
            { model | count = model.count - 1 }

        Reset ->
            { model | count = 0 }

        Open ->
            { model | status = Opened }

        Close ->
            { model | status = Closed }

        MakeProblems ->
            { model | status = Problem }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "- 1" ]
        , div [] [ text (String.fromInt model.count) ]
        , button [ onClick Increment ] [ text "+ 1" ]
        , hr [] []
        , button [ onClick Reset, disabled (ifCountIsZero model.count) ] [ text "Reset" ]
        , hr [] []
        , button [ onClick Open ] [ text "Открыть" ]
        , button [ onClick Close ] [ text "Закрыть" ]
        , button [ onClick MakeProblems ] [ text "Сделать проблемы" ]
        , renderStatus model.status
        ]


renderStatus : Status -> Html Msg
renderStatus status =
    case status of
        Opened ->
            div [] [ text "Открыто" ]

        Closed ->
            div [] [ text "" ]

        Problem ->
            div [] [ text "Problems" ]


-- if status then
--     div [] [ text "Открыто" ]
-- else
--     div [] [ text "" ]


ifCountIsZero : Int -> Bool
ifCountIsZero count =
    count == 0
