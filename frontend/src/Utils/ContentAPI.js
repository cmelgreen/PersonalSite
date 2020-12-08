import { useEffect } from 'react'
import { useDispatch, useSelector } from 'react-redux'
import { setContent, setSummaries } from '../Store/Actions'
import axios from 'axios'

import { convertFromRaw } from 'draft-js'
import { stateToHTML } from 'draft-js-export-html'
import ReactHtmlParser from 'react-html-parser'

const apiRoot = '/api'

const renderRTF = (data) => (ReactHtmlParser(stateToHTML(convertFromRaw(data))))

export const usePostByID = (id) => {    
    const dispatch = useDispatch()
   
    useEffect(() => {
      axios.get(apiRoot+'/post', {params: {id}})
        .then(resp => dispatch(setContent(renderRTF(resp.data.content))))
        .catch(() => dispatch(setContent('')))
      
        return () => dispatch(setContent(''))
    }, [])

    return useSelector(state => state.content)
}

export const createPost = (post) => {
  axios.post(apiRoot+'/post', post)
    
}

export const usePostSummaries = () => {
  const dispatch = useDispatch()

  useEffect(() => {
    axios.get(apiRoot+'/post-summaries')
      .then(resp => dispatch(setSummaries(resp.data.posts)))
      .catch(() => dispatch(setSummaries([])))
  }, [])

  return useSelector(state => state.summaries)
}

export const useUpdatePostSummaries = () => {
  const dispatch = useDispatch()

  axios.get(apiRoot+'/post-summaries')
    .then(resp => dispatch(setSummaries(resp.data.posts)))
    .catch(() => dispatch(setSummaries([])))
}

export const addPost = (title, content) => {
    axios.post(api, {id: title, content: content})
}