module Concourse.Pagination exposing
    ( Direction(..)
    , Page
    , Paginated
    , Pagination
    , chevron
    , chevronContainer
    , equal
    )

import Colors
import Html
import Html.Attributes exposing (style)


type alias Paginated a =
    { content : List a
    , pagination : Pagination
    }


type alias Pagination =
    { previousPage : Maybe Page
    , nextPage : Maybe Page
    }


type alias Page =
    { direction : Direction
    , limit : Int
    }


type Direction
    = Since Int
    | Until Int
    | From Int
    | To Int


directionEqual : Direction -> Direction -> Bool
directionEqual d1 d2 =
    case ( d1, d2 ) of
        ( Since p1, Since p2 ) ->
            p1 == p2

        ( Until p1, Until p2 ) ->
            p1 == p2

        ( From p1, From p2 ) ->
            p1 == p2

        ( To p1, To p2 ) ->
            p1 == p2

        ( _, _ ) ->
            False


equal : Page -> Page -> Bool
equal one two =
    directionEqual one.direction two.direction


chevronContainer : List (Html.Attribute msg)
chevronContainer =
    [ style "padding" "5px"
    , style "display" "flex"
    , style "align-items" "center"
    , style "border-left" <| "1px solid " ++ Colors.background
    ]


chevron :
    { direction : String, enabled : Bool, hovered : Bool }
    -> List (Html.Attribute msg)
chevron { direction, enabled, hovered } =
    [ style "background-image" <|
        "url(/public/images/baseline-chevron-"
            ++ direction
            ++ "-24px.svg)"
    , style "background-position" "50% 50%"
    , style "background-repeat" "no-repeat"
    , style "width" "24px"
    , style "height" "24px"
    , style "padding" "5px"
    , style "opacity" <|
        if enabled then
            "1"

        else
            "0.5"
    ]
        ++ (if hovered then
                [ style "background-color" Colors.paginationHover
                , style "border-radius" "50%"
                ]

            else
                []
           )
