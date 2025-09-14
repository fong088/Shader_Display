using UnityEngine;
using UnityEngine.SceneManagement;

public class GameManager : MonoBehaviour
{
    public Transform sphereParent;   // Drag the parent object of all spheres
    public GameObject gameOverCanvas;

    void Start()
    {
        if (gameOverCanvas != null)
            gameOverCanvas.SetActive(false);

        // Ensure time is running normally at the start
        Time.timeScale = 1f;
    }

    void Update()
    {
        // Check if there are any spheres left under the parent
        if (sphereParent != null && sphereParent.childCount == 0)
        {
            EndGame();
        }

        // Restart when game over and any key pressed
        if (gameOverCanvas != null && gameOverCanvas.activeSelf && Input.anyKeyDown)
        {
            // Reset time before reloading
            Time.timeScale = 1f;
            SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
        }
    }

    void EndGame()
    {
        Time.timeScale = 0f; // Pause the game
        if (gameOverCanvas != null)
            gameOverCanvas.SetActive(true);
    }
}
