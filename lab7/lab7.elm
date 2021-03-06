import Browser
import Html exposing (..)
import Http 
import String
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Html.Events exposing (onClick)


-- MAIN

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

main =
  Browser.element { init = init, update = update, subscriptions = subscriptions, view = view }



-- MODEL


type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  , response: String
  }


init : () -> (Model, Cmd Msg)
init _ =
  ( Model "" "" "" "", Cmd.none)



-- UPDATE


type Msg
  = Name String
  | ClickButton
  | Password String
  | PasswordAgain String
  | GotText (Result Http.Error String)


update : Msg -> Model -> (Model,Cmd Msg)
update msg model =
  case msg of
    Name name ->
      ({ model | name = name }, Cmd.none)

    Password password ->
      ({ model | password = password }, Cmd.none)

    PasswordAgain password ->
      ({ model | passwordAgain = password }, Cmd.none)

    ClickButton ->
      ( model, testPost model )

    GotText result ->
            case result of
                Ok val ->
                    ( { model | response = val }, Cmd.none )

                Err error ->
                    ( handleError model error, Cmd.none )

-- TEST POST

testPost : Model -> Cmd Msg
testPost mod =
  Http.post
    { url = "https://mac1xa3.ca/e/fant8/lab7/"
    , body = Http.stringBody "application/x-www-form-urlencoded" ("username=" ++ mod.name ++ "&password=" ++ mod.password)
    , expect = Http.expectString GotText
    }

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ viewInput "text" "Name" model.name Name
    , viewInput "password" "Password" model.password Password
    , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
    , text model.response
    , viewValidation model
    , button [ onClick ClickButton ] [ text "Check Username/Password" ]
    ]

handleError model error =
    case error of
        Http.BadUrl url ->
            { model | response = "bad url: " ++ url }
        Http.Timeout ->
            { model | response = "timeout" }
        Http.NetworkError ->
            { model | response = "network error" }
        Http.BadStatus i ->
            { model | response = "bad status " ++ String.fromInt i }
        Http.BadBody body ->
            { model | response = "bad body " ++ body }

viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg ] []


viewValidation : Model -> Html msg
viewValidation model =
  if model.password == model.passwordAgain then
    div [ style "color" "green" ] [ text "" ]
  else
    div [ style "color" "red" ] [ text "" ]

