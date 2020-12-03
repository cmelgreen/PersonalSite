import { shallowEqual, useDispatch, useSelector } from 'react-redux'

import axios from 'axios'
import { setContent, setSummaries } from '../Store/Actions'

const apiRoot = '/api'

export const fetchPostByID = (id) => (
    axios.get(apiRoot+'/post', {params: {id}})
        .then(resp => resp.data.content)
        .catch(() => '')
)

export const fetchPostSummaries = () => (
    axios.get(apiRoot+'/post-summaries') 
        .then(resp => resp.data.posts)
        .catch(() => '')
)

export const addPost = (title, content) => {
    axios.post(api, {id: title, content: content})
}