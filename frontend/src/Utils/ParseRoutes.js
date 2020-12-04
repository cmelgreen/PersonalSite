import MainPageContainer from "../Components/MainPage/MainPage"
import PostContainer from "../Components/Post/Post"
import Editor from "../Components/Editor/Editor"

const getComponentByName = {
    MainPageContainer: MainPageContainer,
    PostContainer: PostContainer,
    Editor: Editor
}

const ParseRoutes = (routes) => {
    return routes.map((props) => ({...props, component: getComponentByName[props.component]}))
}

export default ParseRoutes