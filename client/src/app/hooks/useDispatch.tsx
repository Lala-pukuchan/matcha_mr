import { useDispatch as useReduxDispatch } from 'react-redux';
import type { AppDispatch } from "../store/store"; // storeの型をインポート

export const useDispatch = () => useReduxDispatch<AppDispatch>();