module NewPatientForm exposing (..)

import Browser
import Html exposing (Html, button, div, fieldset, form, input, label, text)
import Html.Attributes as Attr exposing (value)
import Html.Events exposing (onClick, onInput)
import UsStates exposing (Abbreviation(..))



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
    , sameAsGuardian : String
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
    , sameAsInsurance : String
    , policyHolder : String
    , policyDob : String
    , policySsn : String
    , policyRelationship : String
    , policyRelationshipPhone : String
    , policyEmployer : String
    , policyCompany : String
    , policyPhone : String
    , policyStreet : String
    , policyCity : String
    , policyZip : String
    , policyID : String
    , policyGroup : String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model "" "" "" "" "" Nothing "" "" "" "" "" "" "" "" "" (Just UT) "" "" "" "" "" "" "" "" "" "" "" "" "" "" ""
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
    | UpdateSameAsGuardian String
    | UpdateSameAsInsurance String
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
    | UpdatePolicyHolder String
    | UpdatePolicyDob String
    | UpdatePolicySsn String
    | UpdatePolicyRelationship String
    | UpdatePolicyRelationshipPhone String
    | UpdatePolicyEmployer String
    | UpdatePolicyCompany String
    | UpdatePolicyPhone String
    | UpdatePolicyStreet String
    | UpdatePolicyCity String
    | UpdatePolicyZip String
    | UpdatePolicyID String
    | UpdatePolicyGroup String


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
        
        UpdateSameAsGuardian name ->
            ( { model | sameAsGuardian = name }, Cmd.none )

        UpdateSameAsInsurance name ->
            ( { model | sameAsInsurance = name }, Cmd.none )

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
                mState =
                    UsStates.fromString state
            in
            ( { model | state = mState }, Cmd.none )

        UpdateZip zip ->
            ( { model | zip = zip }, Cmd.none )

        UpdatePolicyHolder name ->
            ( { model | policyHolder = name }, Cmd.none )
        
        UpdatePolicyDob dob ->
            ( { model | policyDob = dob }, Cmd.none )

        UpdatePolicySsn ssn ->
            ( { model | policySsn = ssn }, Cmd.none )

        UpdatePolicyRelationship relationship ->
            ( { model | policySsn = relationship }, Cmd.none )
        
        UpdatePolicyRelationshipPhone phone ->
            ( { model | policyRelationshipPhone = phone }, Cmd.none )
        
        UpdatePolicyEmployer employer ->
            ( { model | policyEmployer = employer }, Cmd.none )
        
        UpdatePolicyCompany company ->
            ( { model | policyCompany = company }, Cmd.none )
        
        UpdatePolicyPhone phone ->
            ( { model | policyPhone = phone }, Cmd.none )
        
        UpdatePolicyStreet street ->
            ( { model | policyStreet = street }, Cmd.none )
        
        UpdatePolicyCity city ->
            ( { model | policyCity = city }, Cmd.none )
        
        UpdatePolicyZip zip ->
            ( { model | policyZip = zip }, Cmd.none )
        
        UpdatePolicyID id ->
            ( { model | policyID = id }, Cmd.none )
        
        UpdatePolicyGroup group ->
            ( { model | policyGroup = group }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    form
        []
        [ div [] [ text <| Debug.toString model ]
        , patientInformation model
        , guardianInformation model
        , insuranceInformation model
        ]


patientInformation : Model -> Html Msg
patientInformation model =
    fieldset
        []
        [ Html.h2 [] [ text "Patient Information" ]
        , textInput "" "First Name" model.firstName UpdateFirstName
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
        [ Html.h2 [] [ text "Parent/Guargian Information" ]
        , textInput "same-as" "Same information as" model.sameAsGuardian UpdateSameAsGuardian
        , Html.p [] [ text "Legal Mother" ]
        , textInput "mother-name" "Name" model.motherName UpdateMotherName
        , dateInput "mother-dob" "DOB" model.motherDob UpdateMotherDob
        , textInput "mother-phone" "Phone" model.motherPhone UpdateMotherPhone
        , Html.p [] [ text "Legal Father" ]
        , textInput "father-name" "Name" model.fatherName UpdateFatherName
        , dateInput "father-dob" "DOB" model.fatherDob UpdateFatherDob
        , textInput "father-phone" "Phone" model.fatherPhone UpdateFatherPhone
        , Html.p [] [ text "Address" ]
        , textInput "street" "Street" model.street UpdateStreet
        , textInput "city" "City" model.city UpdateCity
        , textInput "zip" "Zip" model.city UpdateZip
        , stateOptions
        ]

insuranceInformation : Model -> Html Msg
insuranceInformation model =
    fieldset
        []
        [ Html.h2 [] [ text "Dental Insurance" ]
        , textInput "same-as" "Same information as" model.sameAsInsurance UpdateSameAsInsurance
        , textInput "policy-holder" "Policy Holder" model.policyHolder UpdatePolicyHolder
        , textInput "policy-dob" "DOB" model.policyDob UpdatePolicyDob
        , textInput "policy-ssn" "SSN" model.policySsn UpdatePolicySsn
        , textInput "policy-relationship" "Relationship to Patient" model.policyRelationship UpdatePolicyRelationship
        , textInput "policy-relationship-phone" "Phone" model.policyRelationshipPhone UpdatePolicyRelationshipPhone
        , textInput "policy-employer" "Employer" model.policyEmployer UpdatePolicyEmployer
        , textInput "policy-company" "Dental Insurance Company" model.policyCompany UpdatePolicyCompany
        , textInput "policy-phone" "Phone" model.policyPhone UpdatePolicyPhone
        , Html.p [] [ text "Address" ]
        , textInput "policy-street" "Street" model.policyStreet UpdatePolicyStreet
        , textInput "policy-city" "City" model.policyCity UpdatePolicyCity
        , textInput "policy-zip" "Zip" model.policyZip UpdatePolicyZip
        , textInput "policy-id" "ID #" model.policyID UpdatePolicyID
        , textInput "policy-group" "Group #" model.policyGroup UpdatePolicyGroup
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
                [ text (UsStates.toString state) ]
    in
    div
        []
        [ label [ Attr.for "state" ] [ text "State" ]
        , Html.select
            [ onInput UpdateState, Attr.id "state" ]
            (List.map stateOption UsStates.all)
        ]


genderRadioGroup : Html Msg
genderRadioGroup =
    let
        genders =
            [ M, F ]

        genderToString gender =
            case gender of
                M ->
                    "Male"

                F ->
                    "Female"

        option gender =
            let
                id =
                    genderToString gender
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
