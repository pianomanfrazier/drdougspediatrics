module NewPatientForm exposing (..)

import Browser
import UsStates exposing (Abbreviation(..))
import Html exposing (Html, button, div, fieldset, form, input, label, text)
import Html.Attributes as Attr exposing (value)
import Html.Events exposing (onClick, onInput)



-- MODEL


type Gender
    = M
    | F


type alias Model =
    { firstName : String
    , midName : String
    , lastName : String
    , preferredName : String
    , dob : String -- TODO: parse into a date
    , gender : Maybe Gender
    , fatherName : String
    , fatherDob : String
    , fatherPhone : String
    , motherName : String
    , motherDob : String
    , motherPhone : String
    , street : String
    , city : String
    , state : Maybe UsStates.Abbreviation
    , zip : String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model "" "" "" "" "" Nothing "" "" "" "" "" "" "" "" (Just UT) ""
    , Cmd.none
    )



-- UPDATE


type Msg
    = UpdateFirstName String
    | UpdateMidName String
    | UpdateLastName String
    | UpdatePreferredName String
    | UpdateDob String
    | UpdateGender Gender
    | UpdateFatherName String
    | UpdateFatherDob String
    | UpdateFatherPhone String
    | UpdateMotherName String
    | UpdateMotherDob String
    | UpdateMotherPhone String
    | UpdateStreet String
    | UpdateCity String
    | UpdateState String
    | UpdateZip String



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateFirstName name ->
            ( { model | firstName = name }, Cmd.none )

        UpdateMidName name ->
            ( { model | midName = name }, Cmd.none )

        UpdateLastName name ->
            ( { model | lastName = name }, Cmd.none )

        UpdatePreferredName name ->
            ( { model | preferredName = name }, Cmd.none )

        UpdateDob dob ->
            ( { model | dob = dob }, Cmd.none )

        UpdateGender gender ->
            ( { model | gender = Just gender }, Cmd.none )

        UpdateFatherName name ->
            ( { model | fatherName = name }, Cmd.none )

        UpdateFatherDob dob ->
            ( { model | fatherDob = dob }, Cmd.none )

        UpdateFatherPhone phone ->
            ( { model | fatherPhone = phone }, Cmd.none )

        UpdateMotherName name ->
            ( { model | motherName = name }, Cmd.none )

        UpdateMotherDob dob ->
            ( { model | motherDob = dob }, Cmd.none )

        UpdateMotherPhone phone ->
            ( { model | motherPhone = phone }, Cmd.none )

        UpdateStreet street ->
            ( { model | street = street }, Cmd.none )

        UpdateCity city ->
            ( { model | city = city }, Cmd.none )

        UpdateState state ->
            let
                mState = UsStates.fromString state
            in
            ( { model | state = mState }, Cmd.none )

        UpdateZip zip ->
            ( { model | zip = zip }, Cmd.none )


-- VIEW


view : Model -> Html Msg
view model =
    form
        []
        [ div [] [ text <| Debug.toString model ]
        , patientInformation model
        , guardianInformation model
        ]

patientInformation : Model -> Html Msg
patientInformation model =
    fieldset
        []
        [ textInput "" "First Name" model.firstName UpdateFirstName
        , textInput "" "Middle Name" model.midName UpdateMidName
        , textInput "" "Last Name" model.lastName UpdateLastName
        , textInput "" "Preferred Name" model.preferredName UpdatePreferredName
        , dateInput "" "Date of Birth" model.dob UpdateDob
        , genderRadioGroup
        ]

guardianInformation : Model -> Html Msg
guardianInformation model =
    fieldset
        []
        [ Html.p [] [ text "Legal Mother"]
        , textInput "mother" "Name" model.motherName UpdateMotherName
        , dateInput "mother" "DOB" model.motherDob UpdateMotherDob
        , textInput "mother" "Phone" model.motherPhone UpdateMotherPhone
        , Html.p [] [ text "Legal Father"]
        , textInput "father" "Name" model.fatherName UpdateFatherName
        , dateInput "father" "DOB" model.fatherDob UpdateFatherDob
        , textInput "father" "Phone" model.fatherPhone UpdateFatherPhone

        , textInput "" "Street" model.street UpdateStreet
        , textInput "" "City" model.city UpdateCity
        , textInput "" "Zip" model.city UpdateZip
        , stateOptions
        ]

labelToId : String -> String
labelToId label =
    label
        |> String.toLower
        |> String.replace " " "-"

stateOptions : Html Msg
stateOptions =
    let
        stateOption state =
            Html.option
                [ value <| UsStates.toString state, Attr.selected (state == UT) ]
                [ text (UsStates.toString state)]
    in
    div
        []
        [ label [ Attr.for "state" ] [ text "State" ]
        , Html.select
            [ onInput UpdateState ]
            (List.map stateOption UsStates.all)
        ]

genderRadioGroup : Html Msg
genderRadioGroup =
    let
        genders = [M, F]
        genderToString gender =
            case gender of
                M -> "Male"
                F -> "Female"
        option gender = 
            let
                id = genderToString gender
            in
            Html.span []
                [ input [ Attr.type_ "radio", Attr.name "gender", Attr.id id, Attr.value id, onClick (UpdateGender gender) ] []
                , label [ Attr.for id ] [ text id ]
                ]
    in
    div []
        (List.map option genders)


textInput : String -> String -> String -> (String -> Msg) -> Html Msg
textInput id_ label_ value_ msg =
    let
        id =
            labelToId label_ ++ id_
    in
    div
        []
        [ label [ Attr.for id ] [ text label_ ]
        , input [ Attr.type_ "text", Attr.name id, Attr.id id, value value_, onInput msg ] []
        ]



dateInput : String -> String -> String -> (String -> Msg) -> Html Msg
dateInput id_ label_ value_ msg =
    let
        id =
            labelToId label_ ++ id_
    in
    div
        []
        [ label [ Attr.for id ] [ text label_ ]
        , input [ Attr.type_ "date", Attr.name id, Attr.id id, value value_, onInput msg ] []
        ]



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

