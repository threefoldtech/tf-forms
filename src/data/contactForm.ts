import type { FormInput } from '@/components/FormRenderer.vue'

export const contactFormData: FormInput[][] = [
  [
    {
      label: '',
      type: 'block'
    },
    {
      label: 'Telephone Number',
      placeholder: 'Your answer',
      value: '',
      class: 'my-5',
      name: 'phone'
    },
    {
      label: 'Some more information About You',
      placeholder: 'Your answer',
      type: 'textarea',
      value: '',
      class: 'mb-5',
      name: 'about'
    },
    {
      label: 'What are you interested in?',
      subLabel: 'Please choose what is relevant for you, can select more than one.',
      type: 'block'
    },
    {
      label: 'ThreeFold Cloud = automous cloud as basis for a new Internet',
      type: 'checkbox',
      value: false,
      name: 'tf-cloud'
    },
    {
      label:
        'OurWorld Venture Creator = our mother company, giving birth to companies like ThreeFold',
      type: 'checkbox',
      value: false,
      name: 'venture-creator'
    },
    {
      label: 'Blocks of Licenses/Slots for Companies in a New Sovereign Digital FreeZone',
      type: 'checkbox',
      value: false,
      name: 'licenses'
    },
    {
      label: "I don't know yet",
      type: 'checkbox',
      value: false,
      class: 'mb-7',
      name: 'dk'
    }
  ]
]
