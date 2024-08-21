import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  showDetail(e){
    let detailDisplayElement = document.querySelector('#forecast-detail')
    let detailElement = this.element.querySelector('.forecast-detail')
    detailDisplayElement.innerHTML = detailElement.innerHTML

    e.preventDefault()
  }

  hideDetail(e){
    let detailDisplayElement = document.querySelector('#forecast-detail')
    detailDisplayElement.innerHTML = ''

    e.preventDefault
  }
}
