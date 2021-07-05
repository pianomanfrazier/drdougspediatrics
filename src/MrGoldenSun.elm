module MrGoldenSun exposing (..)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Svg exposing (circle, ellipse, g, path, polygon, svg)
import Svg.Attributes as SA



-- MODEL


type alias Model =
    { count : Int }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { count = 0 }
    , Cmd.none
    )



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- VIEW


radius =
    75


smallSpike : Int -> Html Msg
smallSpike angle =
    polygon
        -- center of base of triangle (center - r - padding)
        -- adjust the y's only
        [ SA.points "90, 50 110, 50 100, 40"
        , SA.transform <| "rotate(" ++ String.fromInt angle ++ ", 100, 100)"
        ]
        []


tallSpike : Int -> Html Msg
tallSpike angle =
    polygon
        [ SA.points "95, 50 105, 50 100, 30"
        , SA.transform <| "rotate(" ++ String.fromInt angle ++ ", 100, 100)"
        ]
        []

sunSpot angle =
    circle
        [ SA.r "3"
        , SA.cx "100"
        , SA.cy "20"
        , SA.transform <| "rotate(" ++ String.fromInt angle ++ ", 100, 100)"
        ]
        []


mrSun : Html Msg
mrSun = 
    svg
        [ SA.width "200"
        , SA.height "200"
        , SA.viewBox "0 0 200 200"
        , SA.fill "#ffe680"
        , SA.strokeWidth "4"
        , SA.strokeLinecap "round"
        , SA.strokeLinejoin "round"
        , SA.id "mr-golden-sun"
        ]
        [ g
            [ SA.id "sun-face"
            , SA.transform "rotate(10, 100, 100)"
            ]
            [ circle [ SA.r "45", SA.cx "100", SA.cy "100" ] []
            , path [ SA.transform "rotate(180, 100, 100)", SA.d "M105 110s3 4 8 4 8-4 8-4" ] []
            , path [ SA.transform "rotate(180, 100, 100)", SA.d "M80 110s3 4 8 4 8-4 8-4" ] []
            , path [ SA.d "M92 110s3 4 8 4 8-4 8-4" ] []
            ]
        , g [ SA.id "sun-outer"]
            [ g [ SA.id "sun-spikes"]
                [ g [ SA.id "small-spikes" ]
                    (List.range 0 5
                        |> List.map (\x -> x * 60)
                        |> List.map smallSpike
                    )
                , g [ SA.id "tall-spikes" ]
                    (List.range 0 5
                        |> List.map (\x -> x * 60 + 30)
                        |> List.map tallSpike
                    )
                ]
            , g [ SA.id "circles"]
                (List.range 0 5
                    |> List.map (\x -> x * 60 + 15)
                    |> List.map sunSpot
                )
            ]
        ]

view : Model -> Html Msg
view model =
    mrSun



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
