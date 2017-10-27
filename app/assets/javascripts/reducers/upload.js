import {
  VIDEO_UPLOAD_REQUEST,
  VIDEO_UPLOAD_PROGRESS,
  VIDEO_UPLOAD_SUCCESS,
  VIDEO_UPLOAD_FAILURE,
  VIDEO_PUBLISH_SUCCESS,
  VIDEO_UPLOAD_RESET,
} from '../actions';

const initialState = {
  uploading: false,
  uploaded: false,
  progress: 0,
};

export default function uploadReducer(state = initialState, action) {
  switch(action.type) {
  case VIDEO_UPLOAD_REQUEST:
    return { ...state, uploaded: false, uploading: true, progress: 0 };
  case VIDEO_UPLOAD_PROGRESS:
    return { ...state, progress: Math.floor((action.payload.loaded / action.payload.total) * 100) };
  case VIDEO_UPLOAD_SUCCESS:
    return { ...state, uploaded: action.payload, uploading: false, progress: 0 };
  case VIDEO_UPLOAD_FAILURE:
    return { ...state, uploaded: false, uploading: false, progress: 0 };
  case VIDEO_PUBLISH_SUCCESS:
    return { ...state, uploaded: action.payload };
  case VIDEO_UPLOAD_RESET:
    return { ...state, uploaded: false, uploading: false, progress: 0 };
  default:
    return state;
  }
};
