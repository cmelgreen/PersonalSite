import { shallowEqual, useDispatch, useSelector } from 'react-redux'

import axios from 'axios'
import { setContent, setSummaries } from '../Store/Actions'

const apiRoot = '/api'

export const fetchPostByID = (id) => {
    const dispatch = useDispatch()

    axios.get(apiRoot+'/post', {params: {id}})
        .then(resp => dispatch(setContent(resp.data.content)))
        .catch(() => dispatch(setContent('')))

}

export const clearCurrentPost = () => {
    const dispatch = useDispatch()

    return () => dispatch(setContent(''))
}

export const fetchPostSummaries = () => {
    const dispatch = useDispatch()

    axios.get(apiRoot+'/post-summaries') 
        .then(resp => dispatch(setSummaries(resp.data.posts)))
        .catch(() => dispatch(setSummaries()))
}

export const addPost = (title, content) => {
    axios.post(api, {id: title, content: content})
}