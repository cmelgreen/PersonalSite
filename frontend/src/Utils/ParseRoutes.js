import  MainPageContainer from "../Components/MainPage"
import  PostContainer from "../Components/Post"

const getComponentByName = {
    MainPageContainer: MainPageContainer,
    PostContainer: PostContainer
}

export const ParseRoutes = (routes) => {
    return routes.map((props) => ({...props, component: getComponentByName[props.component]}))
}