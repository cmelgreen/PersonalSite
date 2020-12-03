import { useEffect } from 'react'

import { useDispatch, useSelector } from 'react-redux'

import axios from 'axios'
import { setContent, setSummaries } from '../Store/Actions'

const apiRoot = '/api'

export const getPostByID = (id) => {    
    const dispatch = useDispatch()
   
    useEffect(() => {
      axios.get(apiRoot+'/post', {params: {id}})
        .then(resp => dispatch(setContent(resp.data.content)))
        .catch(() => dispatch(setContent('')))
      
        return () => dispatch(setContent(''))
    }, [])

    return useSelector(state => state.content)
}

export const getPostSummaries = () => {
  const dispatch = useDispatch()

  useEffect(() => {
    axios.get(apiRoot+'/post-summaries')
      .then(resp => dispatch(setSummaries(resp.data.posts)))
      .catch(() => dispatch(setSummaries([])) )
  }, [])

  return useSelector(state => state.summaries)
}

export const addPost = (title, content) => {
    axios.post(api, {id: title, content: content})
}