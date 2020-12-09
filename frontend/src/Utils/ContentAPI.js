import { useEffect } from 'react'
import { useDispatch, useSelector } from 'react-redux'
import { setContent, setSummaries } from '../Store/Actions'
import axios from 'axios'

import ReactHtmlParser from 'react-html-parser'

const apiRoot = '/api'

const renderRTF = (data) => {
  console.log(data)
  return ReactHtmlParser(data)
}

export const usePostRawByID = (id) => {
  useEffect(() => {
    axios.get(apiRoot+'/post', {params: {id}})
      .then(resp => dispatch(setContent(renderRTF(resp.data.content))))
      .catch(() => dispatch(setContent('')))
    
      return () => dispatch(setContent(''))
  }, [])
}

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

export const createPost = (title, summary, data, tags) => {
  const post = {title: title, summary: summary, rawContent: data}
  axios.post(apiRoot+'/post', post)
    .then(resp => console.log(resp))
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