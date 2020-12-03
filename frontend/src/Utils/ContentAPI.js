import { useEffect } from 'react'

import { useDispatch, useSelector } from 'react-redux'

import axios from 'axios'
import { setContent, setSummaries } from '../Store/Actions'

const apiRoot = '/api'

export const fetchPostByID = (id) => (
    axios.get(apiRoot+'/post', {params: {id}})
        .then(resp => resp.data.content)
        .catch(() => '')
)

export const fetchPostSummaries = () => {
  const dispatch = useDispatch()

  useEffect(() => {
    axios.get('/api/post-summaries')
      .then(resp => dispatch(setSummaries(resp.data.posts)))
      .catch(() => dispatch(setSummaries([])) )
  }, [])

  return useSelector(state => state.summaries)
}

export const addPost = (title, content) => {
    axios.post(api, {id: title, content: content})
}