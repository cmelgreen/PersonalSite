import  MainPageContainer from "../Components/MainPage/MainPage"
import  PostContainer from "../Components/Post/Post"

const getComponentByName = {
    MainPageContainer: MainPageContainer,
    PostContainer: PostContainer
}

const ParseRoutes = (routes) => {
    return routes.map((props) => ({...props, component: getComponentByName[props.component]}))
}

export default ParseRoutes