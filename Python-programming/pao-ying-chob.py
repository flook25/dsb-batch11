# rock_paper_scissors_app.py

import streamlit as st
import random

# Title
st.title("🪨📄✂️ Rock, Paper, Scissors Game")

# Initialize session state
if 'win' not in st.session_state:
    st.session_state.win = 0
    st.session_state.loss = 0
    st.session_state.tie = 0
    st.session_state.round = 0

# Move mapping
data_move = {1: "Rock", 2: "Paper", 3: "Scissors"}

# Player move
player_move = st.radio("Choose your move:", [1, 2, 3], format_func=lambda x: data_move[x])
if st.button("Play"):
    player_choice = data_move[player_move]
    computer_choice = random.choice(list(data_move.values()))

    # Compare
    if player_choice == computer_choice:
        result = "- Tie 😁 -"
        st.session_state.tie += 1
    elif (player_choice == 'Rock' and computer_choice == 'Paper') or \
         (player_choice == 'Paper' and computer_choice == 'Scissors') or \
         (player_choice == 'Scissors' and computer_choice == 'Rock'):
        result = "- You Loss 😭 -"
        st.session_state.loss += 1
    else:
        result = "- You Win 😎 -"
        st.session_state.win += 1

    st.session_state.round += 1

    # Display results
    st.markdown(f"**Round:** {st.session_state.round}")
    st.markdown(f"**Computer Move:** {computer_choice} | **Player Move:** {player_choice}")
    st.markdown(f"**Result:** {result}")
    st.success(f"Win: {st.session_state.win} | Loss: {st.session_state.loss} | Tie: {st.session_state.tie}")

# Reset button
if st.button("Reset Game"):
    st.session_state.win = 0
    st.session_state.loss = 0
    st.session_state.tie = 0
    st.session_state.round = 0
    st.experimental_rerun()

