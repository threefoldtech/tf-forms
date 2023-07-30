import '@vue/runtime-core'
import * as Htmx from 'htmx.org'

export declare module '@vue/runtime-core' {
  // export interface GlobalComponents {
  //   // FormValidator: typeof FormValidator
  // }

  interface ComponentCustomProperties {
    $api: string
  }
}

export declare global {
  export interface Window {
    htmx: typeof Htmx
  }
}
