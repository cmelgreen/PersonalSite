import { useDispatch, useSelector } from 'react-redux'

import axios from 'axios'
import { setContent } from '../Store/Actions'

const api = '/api/post'

export const getPostByID = (id) => {
    const dispatch = useDispatch()
    
    axios.get(api, {params: {id}})
        .then((resp) => {
            console.log(resp)
            dispatch(setContent(resp.data.content))
        })
        .catch(() => dispatch(setContent('')))

    return useSelector((state) => state.content)
}

export const addPost = (title, content) => {
    axios.post(api, {id: title, content: content})
}