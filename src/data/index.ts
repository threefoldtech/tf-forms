import type { FormInput } from '@/components/FormRenderer.vue'
import { ref, watch, type Ref } from 'vue'

export function useFormData(key: string, fallbackData: FormInput[][]): Ref<FormInput[][]> {
  // const maybeForm = localStorage.getItem(key)

  // if (maybeForm) {
  //   try {
  //     fallbackData = JSON.parse(maybeForm)
  //   } catch {
  //     /* Pass */
  //   }
  // }

  // localStorage.setItem(key, JSON.stringify(fallbackData))

  const form = ref(fallbackData)
  // watch(form, (form) => localStorage.setItem(key, JSON.stringify(form)), { deep: true })
  return form
}

export function getFormData(formData: FormInput[][]) {
  const data: any = {}
  for (const form of formData) {
    for (const input of form) {
      if (input.type === 'block' || !input.name) continue
      data[input.name] = input.value
    }
  }

  return data
}

export * from './investmentForm'
export * from './contactForm'
export * from './presaleForm'
