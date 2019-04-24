-- import modules
module DataVisualizer exposing (..)
import Browser
import Browser.Navigation exposing (load)
import Http exposing (..)
import Html exposing (..)
import Html.Events exposing (..)
import Html.Events as Events
import Html.Attributes exposing (..)
import String
import List exposing (..)
import Json.Decode as JDecode
import Json.Encode as JEncode
import String

main =
  Browser.element { init = init, update = update, , subscriptions = \_ -> Sub.none, view = view }

rootUrl =
    "http://localhost:8000"


-- model

type alias Model = { age : List Int
                    , year : List Int
                    , program: List String
                    , gpa: List Float
                    , school: List String
                    , currentAge : String
                    , currentYear : String
                    , currentProgram : String
                    , currentGpa : String
                    , currentSchool : String
                    , currentScreen: Screen
                    , name: String
                    , password: String
                    , error: String }

-- messages

type Msg  = ChangeAge String
            | ChangeYear String
            | ChangeProgram String
            | ChangeGPA String
            | ChangeSchool String
            | Submit
            | ViewGraphs
            | ToSurvey
            | NewName String -- Name text field changed
            | NewPassword String -- Password text field changed
            | GotLoginResponse (Result Http.Error String) -- Http Post Response Received
            | LoginButton -- Login Button Pressed



-- screen type

type Screen = Graphs | Loggin | Survey

-- init

init : Model
init =
  ({ age = []
  , year = []
  , program = []
  , gpa = []
  , school = []
  , currentAge = ""
  , currentYear = ""
  , currentProgram = ""
  , currentGpa = ""
  , currentSchool = ""
  , currentScreen = Loggin
  , name = ""
  , password = ""
  , error ""}, Cmd.none)

-- update

update : Msg -> Model -> Model
update message model =
  case message of

    -- change current user information
    ChangeAge userAge ->
      ({model | currentAge = userAge}, Cmd.none)

    ChangeYear userYear ->
      ({model | currentYear = userYear}, Cmd.none)

    ChangeProgram userProgram ->
      ({model | currentProgram = userProgram }, Cmd.none)

    ChangeGPA userGpa ->
      ({model | currentGpa = userGpa}, Cmd.none)

    ChangeSchool userSchool ->
      ({model | currentSchool = userSchool}, Cmd.none)

    -- update lists with current student information
    Submit ->
      ({model | age = model.age ++ [Maybe.withDefault 0 (String.toInt (model.currentAge))], year = model.year ++ [ Maybe.withDefault 0 (String.toInt(model.currentYear))], program = model.program ++ [model.currentProgram], gpa = model.gpa ++ [Maybe.withDefault 0 (String.toFloat(model.currentGpa))], school = model.school ++ [model.currentSchool]}, Cmd.none)

    -- change screen to graphs and clear current info
    ViewGraphs ->
      ({model | currentScreen = Graphs, age = "", year = "", program = "", gpa = "", program = ""}, Cmd.none)

    -- change screen to survey and clear current info
    ToSurvey ->
      ({model | currentScreen = Survey, age = "", year = "", program = "", gpa = "", program = ""}, Cmd.none)

    NewName name ->
      ( { model | name = name }, Cmd.none )

    NewPassword password ->
      ( { model | password = password }, Cmd.none )

    LoginButton ->
      ( model, loginPost model )

    GotLoginResponse result ->
      case result of
        Ok "LoginFailed" ->
          ( { model | error = "failed to login" }, Cmd.none )

        Ok _ ->
            ( model, load (rootUrl ++ "static/userpage.html") )

        Err error ->
            ( handleError model error, Cmd.none )



-- view

view : Model -> Html Msg
view model =
  case model.currentScreen of

    Loggin ->

      div []
        [ div []
            [ viewInput "text" "Name" model.name NewName
            , viewInput "password" "Password" model.password NewPassword
            ]
        , div []
            [ button [ Events.onClick LoginButton ] [ text "Login" ]
            ]
        ]

    Survey ->

      div [style "font-family" "Helvetica"]
        [  h1  [ style "font-weight" "bold"]   [ Html.text "Student Information Survey" ]
        , p [style "font-size" "15px"] [ Html.text "Fill out the survey and click 'Go to Visualizer' to see your data as part of the student data visualizer."]
        , p [] [ Html.text "Age: "]
        , input [ placeholder "eg. 20", value model.currentAge, onInput ChangeAge ] []
        , br [] []
        , p [] [ Html.text "Year: "]
        , input [ placeholder "eg. 2", value model.currentYear, onInput ChangeYear ] []
        , br [] []
        , p [] [Html.text "Program: "]
        , input [ placeholder "eg. Social Science", value model.currentProgram, onInput ChangeProgram ] []
        , br [] []
        , p [] [Html.text "GPA: "]
        , input [ placeholder "eg. 4.0", value model.currentProgram, onInput ChangeGPA ] []
        , br [] []
        , p [] [ Html.text "School: "]
        , input [ placeholder "eg. McMaster University", value model.currentSchool, onInput ChangeSchool ] []
        , br [] []
        , br [] []
        , button [onClick Submit] [Html.text "Submit"]
        , button [onClick ViewGraphs] [Html.text "Go to Visualizer!"]
        ]

    Graphs ->

viewInput : String -> String -> String -> (String -> Msg) -> Html Msg
viewInput t p v toMsg =
    input [ type_ t, placeholder p, Events.onInput toMsg ] []

--encode password

passwordEncoder : Model -> JEncode.Value
passwordEncoder model =
    JEncode.object
        [ ( "username"
          , JEncode.string model.name
          )
        , ( "password"
          , JEncode.string model.password
          )
        ]

-- login post

loginPost : Model -> Cmd Msg
loginPost model =
    Http.post
        { url = rootUrl ++ "userauthapp/loginuser/"
        , body = Http.jsonBody <| passwordEncoder model
        , expect = Http.expectString GotLoginResponse
        }

-- handle errors

handleError : Model -> Http.Error -> Model
handleError model error =
    case error of
        Http.BadUrl url ->
            { model | error = "bad url: " ++ url }

        Http.Timeout ->
            { model | error = "timeout" }

        Http.NetworkError ->
            { model | error = "network error" }

        Http.BadStatus i ->
            { model | error = "bad status " ++ String.fromInt i }

        Http.BadBody body ->
            { model | error = "bad body " ++ body }
