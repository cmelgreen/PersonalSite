import MainPageContainer from "../Components/MainPage/MainPage"
import PostContainer from "../Components/Post/Post"
import CMS from "../Components/CMS/CMS"

const getComponentByName = {
    MainPageContainer: MainPageContainer,
    PostContainer: PostContainer,
    CMS: CMS
}

const ParseRoutes = (routes) => {
    return routes.map((props) => ({...props, component: getComponentByName[props.component]}))
}

export default ParseRoutes