import axios from 'axios';

export const VIDEO_FETCH_REQUEST = 'VIDEO_FETCH_REQUEST';
export const VIDEO_FETCH_SUCCESS = 'VIDEO_FETCH_SUCCESS';
export const VIDEO_FETCH_FAILURE = 'VIDEO_FETCH_FAILURE';

export const VIDEO_UPLOAD_REQUEST  = 'VIDEO_UPLOAD_REQUEST';
export const VIDEO_UPLOAD_PROGRESS = 'VIDEO_UPLOAD_PROGRESS';
export const VIDEO_UPLOAD_SUCCESS  = 'VIDEO_UPLOAD_SUCCESS';
export const VIDEO_UPLOAD_FAILURE  = 'VIDEO_UPLOAD_FAILURE';

export const VIDEO_PUBLISH_REQUEST = 'VIDEO_PUBLISH_REQUEST';
export const VIDEO_PUBLISH_SUCCESS = 'VIDEO_PUBLISH_SUCCESS';
export const VIDEO_PUBLISH_FAILURE = 'VIDEO_PUBLISH_FAILURE';

export const VIDEO_UPLOAD_RESET = 'VIDEO_UPLOAD_RESET';

export const UPLOADS_FETCH_REQUEST = 'UPLOADS_FETCH_REQUEST';
export const UPLOADS_FETCH_SUCCESS = 'UPLOADS_FETCH_SUCCESS';
export const UPLOADS_FETCH_FAILURE = 'UPLOADS_FETCH_FAILURE';

export const fetchVideo = id => dispatch => {
  dispatch({ type: VIDEO_FETCH_REQUEST });

  axios.get(`/api/v1/videos/${id}`)
       .then(({ data }) => dispatch({ type: VIDEO_FETCH_SUCCESS, payload: data }))
       .catch(error => dispatch({ type: VIDEO_FETCH_FAILURE, error }));
};

export const uploadVideo = file => dispatch => {
  dispatch({ type: VIDEO_UPLOAD_REQUEST });

  const data = new FormData();

  data.append('file', file);

  axios.post('/api/v1/videos', data, { onUploadProgress: ({ loaded, total }) => dispatch({ type: VIDEO_UPLOAD_PROGRESS, payload: { loaded, total } }) })
       .then(({ data }) => dispatch({ type: VIDEO_UPLOAD_SUCCESS, payload: data }))
       .catch(error => dispatch({ type: VIDEO_UPLOAD_FAILURE, error }));
};

export const publishUploadedVideo = ({ title, description }) => (dispatch, getState) => {
  const { id } = getState().upload.uploaded;

  dispatch({ type: VIDEO_PUBLISH_REQUEST });

  axios.put(`/api/v1/videos/${id}`, { title, description, published: true })
       .then(({ data }) => dispatch({ type: VIDEO_PUBLISH_SUCCESS, payload: data }))
       .catch(error => dispatch({ type: VIDEO_PUBLISH_FAILURE, error }));
};

export const fetchUploads = () => dispatch => {
  dispatch({ type: UPLOADS_FETCH_REQUEST });

  axios.get('/api/v1/videos')
       .then(({ data }) => dispatch({ type: UPLOADS_FETCH_SUCCESS, payload: data }))
       .catch(error => dispatch({ type: UPLOADS_FETCH_FAILURE }));
};

export const resetUploadedVideo = () => ({
  type: VIDEO_UPLOAD_RESET,
});
