import { shallowEqual, useDispatch, useSelector } from 'react-redux'

import axios from 'axios'
import { setContent, setSummaries } from '../Store/Actions'

const apiRoot = '/api'

export const getPostByID = (id) => {
    const dispatch = useDispatch()
    
    axios.get(apiRoot+'/post', {params: {id}})
        .then((resp) => {
            console.log(resp)
            dispatch(setContent(resp.data.content))
        })
        .catch(() => dispatch(setContent('')))

    return useSelector((state) => state.content)
}

export const getPostSummaries = () => {
    const dispatch = useDispatch()

    axios.get(apiRoot+'/post-summaries') 
        .then((resp) => {
            console.log(resp)
            dispatch(setSummaries(resp.data))
        })
        .catch(() => dispatch(setSummaries('')))

    return useSelector((state) => state.summaries, shallowEqual)
}

export const addPost = (title, content) => {
    axios.post(api, {id: title, content: content})
}