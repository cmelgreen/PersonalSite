import { shallowEqual, useDispatch, useSelector } from 'react-redux'

import axios from 'axios'
import { setContent, setSummaries } from '../Store/Actions'

const apiRoot = '/api'

export const fetchPostByID = (id, dispatch) => {
    axios.get(apiRoot+'/post', {params: {id}})
        .then(resp => dispatch(setContent(resp.data.content)))
        .catch(() => dispatch(setContent('')))
}

export const clearCurrentPost = (dispatch) => {
    return () => dispatch(setContent(''))
}

export const fetchPostSummaries = (dispatch) => {
    axios.get(apiRoot+'/post-summaries') 
        .then(resp => dispatch(setSummaries(resp.data.posts)))
        .catch(() => dispatch(setSummaries()))
}

export const addPost = (title, content) => {
    axios.post(api, {id: title, content: content})
}